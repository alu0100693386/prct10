require './Fich/matriz.rb'
require "./Fich/matriz/version"
require './Fich/matriz/fr.rb'
require './Fich/matriz/metodos.rb'
require "test/unit"

class Test_Fraccion < Test::Unit::TestCase


        def setup #definicion de variables para el test
        @v1=[0,0,0,4]
	@v2=[2,Fraccion.new(3,4),7,0]
	@v3=[Fraccion.new(7,3),Fraccion.new(4,3),8,Fraccion.new(1,2)]
	@v4=[1,4,2,3]        
        end

        def test_inizialize
		@a=Matrix.new(2,2,@v3) 
		assert_equal("[7/3 4/3] \n[8 1/2] \n", @a.to_s)
        end

	def test_suma
		@a=Matrix.new(2,2,@v1)
		@b=Matrix.new(2,2,@v2)
		@c=Matrix.new(2,2,@v3)
		@d=MatrixDispersa.new(2,2,@v1,"COO")
		assert_equal("[2 3/4] \n[7 4] \n",(@a+@b).to_s)
		assert_equal("[13/3 25/12] \n[15 1/2] \n",(@b+@c).to_s)	
		assert_equal("[2 3/4] \n[7 4] \n",(@d+@b).to_s)
	end
	
	def test_mul
		@a=Matrix.new(2,2,@v3)
                @b=MatrixDispersa.new(2,2,@v1,"COO")		
		
		assert_equal("[0 16/3] \n[0 2] \n",(@a*@b).to_s)
		assert_equal("[0 0] \n[32 2] \n",(@b*@a).to_s)		
	end

	def test_mm
		@a=Matrix.new(2,2,@v3)
                @b=MatrixDispersa.new(2,2,@v1,"COO")
		
		assert_equal("1/2",@a.min)
                assert_equal("4",@b.max)		
	end


        #Liberacion de las variables de prueba

        def tear_down
        end
        
end
