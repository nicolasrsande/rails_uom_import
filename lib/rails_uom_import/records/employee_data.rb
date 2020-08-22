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
    field :nombre, 30, '12-42', :alphanumeric
    field :calle, 32, '43-73', :alphanumeric
    field :calle_numero, 5, '74-78', :alphanumeric
    field :filler1, 8, '79-86', :alphanumeric
    field :localidad, 13, '87-99', :alphanumeric
    field :cod_pos, 4, '100-103', :alphanumeric
    field :provincia, 2, '104-105', :alphanumeric
    field :filler2, 4, '106-109', :alphanumeric
    field :estado_civil, 2, '110-111', :alphanumeric
    field :sexo, 1, '112-112', :alphanumeric
    field :nacionalidad, 3, '113-115', :alphanumeric
    field :filler2, 4, '116-119', :alphanumeric
    field :fecha_nacimiento, 8, '120-127', :alphanumeric
    field :filler3, 2, '128-129', :alphanumeric
    field :situacion, 2, '130-131', :alphanumeric
    field :filler4, 3, '132-134', :alphanumeric
    field :incapacidad, 1, '135-135', :alphanumeric
    field :filler5, 4, '136-139', :alphanumeric
    field :sindicato, 1, '140-140', :alphanumeric
    field :filler6, 1, '141-141', :alphanumeric
    field :sueldo, 8, '142-149', :alphanumeric
    field :categoria, 2, '150-151', :alphanumeric

    def initialize(record)
      @filler1 = @filler2 = @filler3 = @filler4 = @filler5 = @filler6 = ' '
      @sexo = record[:sexo] || 'M' # Default "M" Masculino
      @cuil = record[:cuil]
      @nombre = record[:nombre]
      @nacionalidad = record[:nacionalidad] || 0 # Default 00 Not Selected
      @provincia = record[:provincia] || '1' # Default 'CABA'
      @localidad = record[:localidad] || 'CABA' # Default 'CABA'
      @cod_pos = record[:cod_pos] || 1414 # Default 1414 'Villa Crespo'
      @calle = record[:calle] || ' ' # Default Blank not required
      @calle_numero = record[:calle_numero] || ' ' # Default Blank not required
      @estado_civil = record[:estado_civil] || '1' # Default "SOLTERO"
      @fecha_nacimiento = record[:fecha_nacimiento] || ' ' # Default Blank not required
      @situacion = record[:situacion] || '01' # Default "Recibe haberes regularmente"
      @sindicato = record[:sindicato] || 'S' # Default "Si"
      @sueldo = record[:sueldo]
      @categoria = record[:categoria] || '2' # Default "Operario"
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
