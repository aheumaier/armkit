class Variables

  @@registry = {}
  @@obj_cache = []

  attr_reader :name, :value

  def initialize name, value
    @name = name
    @value = value
  end

  def self.add(&block)
    instance_eval(&block)
  end

  def to_ref name
    "[variable('#{name}')]"
  end

  def self.registry
    @@registry
  end

  def self.render
  end


  def self.method_missing(m, *args, &block)
    if block_given?
      puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect} and #{block}"
      if @parent.nil?
        @parent = [m]
      else
        @parent << m
      end
      @previousBlock = true
      instance_eval(&block)
    else
      puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect} and no block"
      @previousBlock = @previousBlock || false
      if @parent

        if @previousBlock == true

          puts "From previous Block"
          @h = {m => args.join }
          @parent.reverse.each do |element|
            @h = {element => @h }
          end
          pp @h
          var = Variables.new(m, @h)
          @@registry[@parent.first] = var

        else

          puts "From no previous block"
          @h = {m => args.join }
          @parent.reverse.each do |element|
            @h = {element => @h }
          end
          pp @h
          var = Variables.new(m, @h_old.update(@h))
          pp @h_old.update(@h)
          @@registry[@parent.first] = var

        end
        @h_old = @h

        @previousBlock = false

      else
puts @previousBlock
        var = Variables.new(m, args.join )
        @@registry[var.name] = var
      end
    end
  end
end