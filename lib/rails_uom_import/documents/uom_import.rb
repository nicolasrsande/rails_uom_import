module RailsUomImport

  class UomImport < Fixy::Document

    def initialize(nomina)
      @nomina = nomina
    end

    def build
      @nomina.each do |employee_data|
        append_record EmployeeData.new(employee_data)
      end
    end
  end

end