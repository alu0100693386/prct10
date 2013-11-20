
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

class MatrixDispersa < Matrix
  attr_reader :row, :col, :A, :IA, :JA, :porcVacio, :representacion
  #COO  
	# A valores de matriz distintos de cero (NNZ)
	# IA fila (NNZ)	
	# JA columna (NNZ)
	
	#CSR
	# A valores de matriz distintos de cero (NNZ)
	# IA indice donde empieza la fila i dentro del array A  (FILAS+1)
	# JA columna de cada elemento del array A (NNZ)

	def initialize(row, col, v, representacion)
		super(row, col)
				
		contador = 0
		for i in 0..v.size
		   	if(v[i] != 0)
		   		contador+=1
		   	end
		end
		@nnz = contador
		@A = Array.new
		@IA = Array.new
		@JA = Array.new
		@representacion = representacion
	
		case representacion
		  when "COO"
		      construirCOO(v)
		  when "CSR"
		      construirCSR(v)
		end
	end

  	def construirCOO(v)
    		#Rellenar matriz con un vector dado.
    		if(v.instance_of? Array)
      			k = 0
      			for aux_fil in 1..@row
        			for aux_col in 1..@col
          				if(k >= v.size())
            					aux_value = 0
          				else
            					aux_value = v[k]
          				end
          				k = k+1
          
          				if(aux_value !=0)
           					@A.push(aux_value)
            					@IA.push(aux_fil)
            					@JA.push(aux_col)
          				end 
        			end        			
      			end
    		end  	
  	end

	def construirCSR(v)
    		k = 0
    		filasAnadida = true
    		#Rellenar matriz con un vector dado.
    		if(v.instance_of? Array)
      			for aux_fil in 1..@row
        				cambioFil = true
        				for aux_col in 1..@col
          					if(k >= v.size())
            						aux_value = 0
          					else
            						aux_value = v[k]
          					end
          					k = k+1
          					if(aux_value !=0)
            						@A.push(aux_value)
            						@JA.push(aux_col)
            						if(cambioFil == true)
              							@IA.push(@A.size()-1)
              							cambioFil = false
            						end            
          				end
        			end
      				if(cambioFil == true)
              				@IA.push(@nnz)
        			end
      			end
    		end
  	end 

	def pasarCSR!()
    		@representacion = "CSR"
    		aux_IA = Array.new(@row+1, @nnz)

    		for i in 0..@A.size-1
      			fila = @IA[i]
      			if(aux_IA[fila-1] == @nnz)
				aux_IA[fila-1] = i
      			end
    		end
    		@IA = aux_IA
    		puts @IA
  		end  
  
  	def pasarCOO!()
    		@representacion = "COO"
    		aux_IA = Array.new(@A.size, @nnz)

    		for i in 0..@IA.size-1
      			k = @IA[i]
      			if(k != @nnz)
				aux_IA[k] = i+1
      			end
    		end
    		anterior = aux_IA[0]
    		for i in 1..aux_IA.size()-1
      			if(aux_IA[i] == @nnz)
				aux_IA[i] == anterior
      			else
				anterior = @IA[i]
      			end
    		end
    		@IA = aux_IA
    		puts @IA
  	end

	def pasarCSR()
    		v = to_densaCOO()
    		return MatrixDispersa.new(@row,@col,v,"CSR")
  	end  
  
  	def pasarCOO()
    		v = to_densaCSR()
    		return MatrixDispersa.new(@row,@col,v,"COO")
  	end


	def to_sparseString()
	  	cadena = "//////MATRIZ\n"
	  	cadena = cadena + self.to_s()+"\n"
		cadena = cadena + "representacion: #{representacion} \n A: [ "
	  	for i in 0..@A.size()
	  		cadena = cadena + @A[i].to_s() + " "
	  	end
	  	cadena = cadena + "]\n"
	  
	  	cadena = cadena + "IA: [ "
	  	for i in 0..@IA.size()
	      		cadena = cadena + @IA[i].to_s() + " "
	  	end
	  	cadena = cadena + "]\n"
	
	  	cadena = cadena + "JA: [ "
	  	for i in 0..@JA.size()
	      		cadena = cadena + @JA[i].to_s() + " "
	  	end
	  	cadena = cadena + "]\n"
	  
	  return cadena
	end

	
	def to_s
		cadena = ""
	  	case @representacion
	    	when "CSR"
	      		v = self.to_densaCSR()
	    	when "COO"
	      		v = self.to_densaCOO()
	  	end
	  	contadorColumna = 1
	  	for i in 0..v.size()-1
	    		if(contadorColumna == 1)
	      			cadena = cadena + "["
	    		end
	    		if(contadorColumna == @col)
	      			cadena = cadena + "#{v[i]}"
	    		else
	      			cadena = cadena + "#{v[i]} "
	    		end

	    		contadorColumna += 1
	    		if(contadorColumna > @col)
	      			cadena = cadena + "] \n"
	      			contadorColumna = 1
	    		end
	  	end
	  	return cadena
	end
  
	def to_densaCOO()
    		v = Array.new
    		k = 0
    		for aux_fil in 1..@row
      			for aux_col in 1..@col
          			if(aux_fil == @IA[k] && aux_col == @JA[k])
            				v.push(@A[k])
            				k += 1
          			else
            				v.push(0)
          			end
      			end
    		end
        	v
  	end	

	def to_densaCSR()
    		total = @row * @col
    
    		contadorFila = 0
    		contadorColumna = 1
    
    		comienzo = 0
    		comienzoFila = @IA[comienzo]
    		finalFila = @IA[comienzo+1]
    
    		v = Array.new
    		k = 0
    
    		for i in 0..total-1
      
      			if(comienzoFila==@nnz)
        			v.push(0)
      			elsif(@JA[k]==contadorColumna && k != finalFila)
        	  		v.push(@A[k])
        	  		k+=1
      			else
        	  		v.push(0)
      			end
      	
      			contadorColumna += 1
      			if(contadorColumna > @col)
        			contadorColumna = 1
        			comienzo += 1
        			comienzoFila=@IA[comienzo]
        			finalFila = @IA[comienzo+1]        
      			end
    		end
    		v
  	end
	
	
 	def to_densa
    		matriz = nil
    		case representacion
       		when "COO"
        	  	v = to_densaCOO()
        	  	matriz = Matrix.new(@row,@col,v)
        	when "CSR"
        	  	v = to_densaCSR()
        	  	matriz = Matrix.new(@row,@col,v)
    		end
    		return matriz
 	end	

	def +(other)
		if ((other.instance_of? (MatrixDispersa)) && representacion == "COO" && other.representacion == "COO")
			v = Array.new(@row*@col)
                	k, l, c= 0, 0, 0 
                	for aux_fil in 1..@row
                        	for aux_col in 1..@col
                                	if(aux_fil == @IA[k] && aux_col == @JA[k])
                                        	v[c]=@A[k]
                                        	k += 1
                                	else
                                        	v[c]=0
                                	end
					if(aux_fil == other.IA[l] && aux_col == other.JA[l])
                                                v[c]+=other.A[l]
                                                l += 1
					end
					c+=1 
                        	end 
                	end
			return MatrixDispersa.new(@row, @col, v, "COO")	
		elsif ((other.instance_of? (MatrixDispersa)))
			a,b=self, other
			if (representacion=="CSR")
				a=self.pasarCOO
			end
			if (other.representacion=="CSR")
				b=other.pasarCOO
			end
			return a+b 
		else
			return other+self.to_densa
		end
	end

	def *(other)
		if (other.instance_of? (MatrixDispersa))
			return self.to_densa*other.to_densa
		else 
			return self.to_densa*other
		end
	end
	
	def multiplicacionK(k)
    		for i in 0..@A.size()-1
      			@A[i] = @A[i]*k
    		end
  	end
	
	def mix
	min=@A[0]
		for i in 1...@A.size
			if (!min.is_a? Fraccion)
                        	t=min
                                min=Fraccion.new(t,1)
                        end
                        if (min>@A[i])
                                min=@A[i]
                        end
		end
	return min.to_s
	end

	def max
        max=@A[0]
                for i in 1...@A.size
                        if (!max.is_a? Fraccion)
                                t=max
                                max=Fraccion.new(t,1)
                        end
                        if (max<@A[i])
                                max=@A[i]
                        end
                end
        return max.to_s
        end 

end
