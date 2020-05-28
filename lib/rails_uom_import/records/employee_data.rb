module RailsUomImport

  class EmployeeData < Fixy::Record
    include Fixy::Formatter::Numeric
    include Fixy::Formatter::Alphanumeric

    set_record_length 149

    # Fields Declaration:
    # -----------------------------------------------------------
    #       name          size      Range             Format
    # ------------------------------------------------------------
    field :cuil, 11, '1-11', :numeric
    field :nombre, 30, '12-41', :alphanumeric
    field :filler, 88, '42-129', :alphanumeric
    field :situacion, 2, '130-131', :numeric
    field :filler2, 8, '132-139', :alphanumeric
    field :sindicato, 1, '140-140', :numeric
    field :filler3, 1, '141-141', :alphanumeric
    field :sueldo, 8, '142-149', :alphanumeric

    def initialize(record)
      @cuil = record[:cuil]
      @nombre = record[:nombre]
      @filler = @filelr2 = @filler3 = ' '
      @situacion = record[:situacion] || 7 # Default "Recibe haberes regularmente"
      @sindicato = record[:sindicato] || 1 # Default "Si"
      @sueldo = record[:sueldo]
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