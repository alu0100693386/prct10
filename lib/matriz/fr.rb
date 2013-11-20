#require './metodos.rb'

class Fraccion
	include Comparable
	attr_reader :n, :d
	
	def initialize(a,b)
		if b==0
			raise "Error de ejecucion. Division entre 0"
		else
			@n,@d = a,b
		end
		#Se simplifica al crear la fraccion		
		@n, @d = @n/mcd(@n, @d), @d/mcd(@n, @d)	
	end

	def to_s
		if (@d != 1)
			return "#{@n}/#{@d}" 
		else 
			return "#{@n}"
		end
	end

	def to_d
		return (@n*1.0)/@d
	end

	def +(other)
		if other.respond_to?("d")
			return Fraccion.new(((mcm(@d, other.d) / @d)*@n) + ((mcm(@d, other.d) / other.d)*other.n),mcm(@d, other.d))
		else
			return Fraccion.new( ((other*@d) + @n), @d)
		end	
	end

	def *(other)
		if other.respond_to?("d")
                        return Fraccion.new(@n*other.n, @d*other.d)
                else
                        return Fraccion.new(other*@n,@d)
                end
	end
	
	def -@
		return Fraccion.new(@n*(-1), @d)
	end

	def coerce(other)
		v=[self, other]
	end

	def <=>(other)
		if other.respond_to?("d")
			self.to_d<=>other.to_d
		else
			self.to_d<=>other
		end
	end
end
