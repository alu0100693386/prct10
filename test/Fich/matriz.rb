require "matriz/version"
require 'matriz/fr.rb'
require 'matriz/metodos.rb'

class Matrix	
	attr_reader :row, :col, :data

	def initialize(row, col, v=0)
		@row, @col = row, col
		
		#Rellenar matriz con un vector dado.
		if(v.instance_of? Array)
      			@data = Array.new(row+1) {Array.new(col+1)}
      			k = 0;
      			for i in 1..row
        			for j in 1..col
                			if(k >= v.size())
                        			aux_value = 0
                			else
                        			aux_value = v[k]        
                        			k = k+1
                			end
                			@data[i][j] = aux_value
        			end
      			end

		#Rellenar matrix con un numero especifico.
    		elsif(v.instance_of? Fixnum)
      			@data = Array.new(row+1) {Array.new(col+1, v)}
   		end   
	end

	def to_s
		cadena = ""
		for i in 1..row
			cadena +="["
      			for j in 1..col
        			if(j!=col)
          				cadena += "#{@data[i][j]} "
        			else
          				cadena += "#{@data[i][j]}"
        			end
      			end
      			cadena +="] \n"
    		end
    		return "#{cadena}"
	end	

	def [](x, y)
    		@data[x][y]
	end 
	
	def +(other)
		if other.instance_of? Matrix
			if(other.row == @row && other.col == @col)
        			aux_vec = Array.new(@row*@col)
        			for j in 1..row
            				for i in 1..col
              					aux_vec[(i-1)+(j-1)*@col]= self[j,i]+other[j,i]	
            				end
        			end      
      				return (Matrix.new(row, col, aux_vec))
			else
				raise "Error de tamaño"		
			end
		else
			return (other.to_densa)+self 
		end		
	end

	
	def []=(x, y, value)
    		@data[x][y] = value
  	end
	
	
	def *(other)
		if(other.instance_of? MatrixDispersa)	
			return self*other.to_densa
		else
        		if(other.row == @col)
          			aux_matrix = Matrix.new(@row,other.col)
          			for i in 1..aux_matrix.row
              				for j in 1..aux_matrix.col
                  				for k in 1..@col
                    					aux_matrix[i,j] += @data[i][k]*other.data[k][j]
                  				end                      
              				end
          			end
        		end
      		end
		aux_matrix
	end
	
	def max
		max=self[1,1]
		for i in 1..@row
			for j in 1..@col
				if (!max.is_a? Fraccion)
					t=max
					max=Fraccion.new(t,1)
				end
				if (max<self[i,j])
					max=self[i,j]
				end
			end
		end
		return max.to_s
	end
	
	def min
		min=self[1,1]
                for i in 1..@row
                        for j in 1..@col
                                if (!min.is_a? Fraccion)
					t=min
                                        min=Fraccion.new(t,1)
                                end
				if (min>self[i,j])
                                        min=self[i,j]
				end
                        end
                end
                return min.to_s
	end

	def vector
		aux_vec = Array.new(@row*@col)
                        for j in 1..row
                                 for i in 1..col
                                          aux_vec[(i-1)+(j-1)*@col]= self[j,i]
                                 end
                	end
	end
end