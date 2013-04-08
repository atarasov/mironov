class ImplementationReport
  include Datagrid

  #
  # Scope
  #

  scope do
    Implementation
  end

  #
  # Filters
  #

  filter(:DAT, :date, :range => true)
  filter(:KOD, :integer)
  filter(:NAIM, :string)
  filter(:SUM, :float)
  filter(:SUMM, :float)
  filter(:SUMY, :float)

  #
  # Columns
  #

  column(:DAT) do
    self.DAT.to_date
  end
  column(:KOD)
  column(:NAIM)
  column(:SUM)
  column(:SUMM)
  column(:SUMY)

end
