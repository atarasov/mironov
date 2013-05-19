class DbfFile < ActiveRecord::Base
  has_attached_file :plan,
                    :url => '/system/plan/:class/:id/:basename.:extension',
                    :path => 'public/system/plan/:class/:id/:filename'

  has_attached_file :implementation,
                    :url => '/system/implementations/:class/:id/:basename.:extension',
                    :path => 'public/system/implementations/:class/:id/:filename'
  attr_accessible :implementation, :plan

  after_save :start_parse



  def start_parse
    Delayed::Job.enqueue(ParseJob.new(self.id))
  end

  def parse_data

    if self.plan.present?
      plan = DBF::Table.new(self.plan.path())
      #ActiveRecord::Migration.drop_table(:PL)
      #eval(plan.schema)
      #plan_delta = plan.find("DATE(DAT) >= ?", (Asrt.last.DAT.to_date - 10.days).to_date)
      Asrt.delete_all
      plan.each do |record|
        encode = Iconv.new('UTF-8','ibm866')
        naim = encode.iconv(record.naim)
        kod = encode.iconv(record.kod)
        Asrt.create(
            :C => record.c,
            :DAT => record.dat,
            :N => record.n,
            :KOD => kod,
            :NAIM => naim,
            :DN => record.dn,
            :PLM => record.plm,
            :PLS => record.pls,
            :PLD => record.pld,
            :VRY => record.vry,
            :VRS => record.vrs,
            :VRD => record.vrd,
            :OST => record.ost,
            :OST1 => record.ost1,
            :RLD => record.rld,
            :NSS => record.nss,
            :A1 => record.a1,
            :A2 => record.a2,
            :A3 => record.a1,
            :A4 => record.a4,
            :A5 => record.a5,
            :A6 => record.a6,
            :A7 => record.a7,
            :A8 => record.a8,
            :A9 => record.a9,
            :P => record.p,
            :AWT => record.awt
        )
      end
    end
    if self.implementation.present?
      implementation = DBF::Table.new(self.implementation.path())
      #ActiveRecord::Migration.drop_table(:RL)
      #eval(implementation.schema)
      #implementation_delta = implementation.find("DATE(DAT) >= ?", (Implementation.last.DAT.to_date - 10.days).to_date )
      Implementation.delete_all
      implementation.each do |record|
        encode = Iconv.new('UTF-8','ibm866')
        naim = encode.iconv(record.naim)
        kod = encode.iconv(record.kod)
        Implementation.create({
                                  :S => record.s,
                                  :N => record.n,
                                  :DAT => record.dat,
                                  :DN => record.dn,
                                  :KOD => kod,
                                  :NAIM => naim,
                                  :SUM => record.sum,
                                  :SUMM => record.summ,
                                  :SUMY => record.sumy,
                                  :P => record.p,
                                  :AWT => record.awt})
      end

    end

  end
  handle_asynchronously :parse_data

end
