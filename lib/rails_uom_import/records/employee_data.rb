module RailsUomImport

  class EmployeeData < Fixy::Record
    include Fixy::Formatter::Numeric
    include Fixy::Formatter::Alphanumeric

    set_record_length 151

    # Fields Declaration:
    # -----------------------------------------------------------
    #       name          size      Range             Format
    # ------------------------------------------------------------
    field :cuil, 11, '1-11', :numeric
    field :nombre, 30, '12-41', :alphanumeric
    field :provincia, 2, '104-105', :numeric
    field :estado_civil, 2, '110-111', :numeric
    field :situacion, 2, '130-131', :numeric
    field :incapacidad, 1, '135-135', :numeric
    field :sindicato, 1, '140-140', :alphanumeric
    field :sueldo, 8, '142-149', :alphanumeric
    field :categoria, 2, '150-151', :numeric

    def initialize(record)
      @cuil = record[:cuil]
      @nombre = record[:nombre]
      @provincia = record[:provincia] || 01 # Default "CABA"
      @estado_civil = record[:estado_civil] || 1 # Default "SOLTERO"
      @situacion = record[:situacion] || 00 # Default "Recibe haberes regularmente"
      @sindicato = record[:sindicato] || 'S' # Default "Si"
      @sueldo = record[:sueldo]
      @categoria = record[:categoria] || 1 # Default "Operario"
      @incapacidad = record[:incapacidad] || 'N' # Default "No"
      define_attr_readers
    end

    ## Define all class variables as attr_reader
    def define_attr_readers
      # get the eigenclass of the current object
      klass = class << self; self; end

      symbols = instance_variables.map { |s|
        # remove the @ at the start of the symbol
        s.to_s[1..-1].to_sym
      }

      # augment the eigenclass
      klass.class_eval do
        symbols.each do |s|
          attr_reader s
        end
      end
    end
  end
end