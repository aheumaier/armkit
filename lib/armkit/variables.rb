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

  def self.getVar var
    Variables.registry[ var.to_s.to_sym ]
  end

  def self.registry
    @@registry
  end

  def self.method_missing(m, *args, &block)
    if block_given?
      puts ""
      puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect} and #{block}"
      if @parent.nil?
        @parent = [m]
      else
        puts "@previousParents: "+@parent.inspect
        if @previousBlock == false

          @parent = @parent.slice(0..-2)

        else
          @parent << m
        end
        puts "@parents: "+@parent.inspect
      end
      @previousBlock = true
      instance_eval(&block)
    else
      puts ""
      puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect} and no block"
      @previousBlock = @previousBlock || false
      if @parent
        if @previousBlock == true
          puts "  @previousBlock is set : "+ @previousBlock.inspect

          @currentHash = {m => args.join }
          @parent.reverse.each do |element|
            @currentHash = {element => @currentHash }
          end
          puts "  @currentHash :" + @currentHash.inspect
          var = Variables.new(m, @currentHash)
          @@registry[@parent.first] = var

        else
          puts "  @previousBlock is set : "+ @previousBlock.inspect

          @currentHash = {m => args.join }
          puts "  @parents : " + @parent.inspect
          @parent.reverse.each do |element|
            @currentHash = {element => @currentHash }
          end
          puts "  @currentHash :" +  @currentHash.inspect
          puts "  @previousHash :" +  @previousHash.inspect

          var = Variables.new(m, @previousHash.insert_at(@currentHash, @parent, {m => args.join } ))

          puts "  @resultingHash: "+ @previousHash.insert_at(@currentHash, @parent, {m => args.join } ).inspect

          @@registry[@parent.first] = var

        end
        @previousHash = @currentHash
        @previousBlock = false

      else
        puts "  @previousBlock is set : "+ @previousBlock.inspect
        var = Variables.new(m, args.join )
        @@registry[var.name] = var
      end
    end
  end
end