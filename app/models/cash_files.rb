class CashFiles < ActiveRecord::Base
  attr_accessible :cash, :cashc, :balance

  has_attached_file :cash,
                    :url => '/system/cash/:class/:id/:basename.:extension',
                    :path => 'public/system/cash/:class/:id/:filename'

  has_attached_file :cashc,
                    :url => '/system/cashc/:class/:id/:basename.:extension',
                    :path => 'public/system/cashc/:class/:id/:filename'

  has_attached_file :balance,
                    :url => '/system/balance/:class/:id/:basename.:extension',
                    :path => 'public/system/balance/:class/:id/:filename'

  after_save :start_parse

  def start_parse
    Delayed::Job.enqueue(ParseCashJob.new(self.id))
  end

  def parse_data

    if self.cash.present?
      cash = DBF::Table.new(self.cash.path())
      #ActiveRecord::Migration.drop_table(:PL)
      #eval(plan.schema)
      #plan_delta = plan.find("DATE(DAT) >= ?", (Asrt.last.DAT.to_date - 10.days).to_date)
      Cash.delete_all
      cash.each do |record|
        encode = Iconv.new('UTF-8','ibm866')
        naim = encode.iconv(record.naim)
        kod = encode.iconv(record.kod)
        Cash.create(
            :N => record.n,
            :DAT => record.dat,
            :KOD => kod,
            :NAIM => naim,
            :SUM => record.sum,
            :BN1 => record.bn1,
            :BN2 => record.bn2,
            :BN3 => record.bn3,
            :BN4 => record.bn4,
            :BN5 => record.bn5,
            :BK1 => record.bk1,
            :BK2 => record.bk2,
            :BK3 => record.bk3,
            :BK4 => record.bk4,
            :BK5 => record.bk5,
            :AWT => record.awt
        )
      end
    end
    if self.cashc.present?
      cashc = DBF::Table.new(self.cashc.path())
      #ActiveRecord::Migration.drop_table(:RL)
      #eval(implementation.schema)
      #implementation_delta = implementation.find("DATE(DAT) >= ?", (Implementation.last.DAT.to_date - 10.days).to_date )
      Cashc.delete_all
      cashc.each do |record|
        encode = Iconv.new('UTF-8','ibm866')
        naim = encode.iconv(record.naim)
        kod = encode.iconv(record.kod)
        Cashc.create({
                                  :N => record.n,
                                  :DAT => record.dat,
                                  :KOD => kod,
                                  :NAIM => naim,
                                  :SUM => record.sum,
                                  :BN1 => record.bn1,
                                  :BN2 => record.bn2,
                                  :BN3 => record.bn3,
                                  :BN4 => record.bn4,
                                  :BN5 => record.bn5,
                                  :BK1 => record.bk1,
                                  :BK2 => record.bk2,
                                  :BK3 => record.bk3,
                                  :BK4 => record.bk4,
                                  :BK5 => record.bk5,
                                  :AWT => record.awt})
      end

    end

    if self.balance.present?
      balance = DBF::Table.new(self.balance.path())
      Balance.delete_all
      balance.each do |record|
        encode = Iconv.new('UTF-8','ibm866')
        naim = encode.iconv(record.namepo)
        nazn = encode.iconv(record.nazn)
        Balance.create({
                                  :DATA => record.data,
                                  :DAT => record.dat,
                                  :RSUM => record.rsum,
                                  :S => record.s,
                                  :NAMEPO => naim,
                                  :NAZN => nazn})

      end

    end

  end

end
