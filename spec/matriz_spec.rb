require 'matriz.rb'

describe Matriz

	        describe "Pruebas Constructor \n" do

                        it "Debe estar inicializado" do
                                @a=Matrix.new(2,2,0)
                                @a.to_s.should eq("[0 0] \n[0 0] \n")
                        end

                        it "Se le debe poder asignar valores por array" do
                                @a=Matrix.new(2,2,[1,2,3,4])
                                @a.to_s.should eq("[1 2] \n[3 4] \n")
                        end
			
			it "Se le debe poder asignar valores por array" do
                                @a=Matrix.new(2,2,[Fraccion.new(1,2),Fraccion.new(1,2),Fraccion.new(2,3),Fraccion.new(1,4)])
                                @a.to_s.should eq("[1/2 1/2] \n[2/3 1/4] \n")
                        end

			it "Se debe poder inicializar con valores mixtos" do
				@a=Matrix.new(2,2,[1, Fraccion.new(1,2), 4, Fraccion.new(3,4)])
				@a.to_s.should eq("[1 1/2] \n[4 3/4] \n")
			end 
				
			it "Se debe poder inicializar matrices dispersas con valores mixtos" do
                                @a=MatrixDispersa.new(2,2,[0, Fraccion.new(1,2), 4,0],"COO")
                                @a.to_s.should eq("[0 1/2] \n[4 0] \n")
                        end 
			
			it "Se debe poder inicializar matrices dispersas con valores mixtos" do
                                @a=MatrixDispersa.new(2,2,[Fraccion.new(3,2), 0,0,1],"CSR")
                                @a.to_s.should eq("[3/2 0] \n[0 1] \n")
                        end      
		end

		describe "Pruebas Operadores \n" do
			before(:each) do
                		@a = Matrix.new(2,2,[1,2,3,4])	
				@b = Matrix.new(2,2,[Fraccion.new(1,2), Fraccion.new(2,3), Fraccion.new(1,2), Fraccion.new(3,4)])			
				@c = Matrix.new(2,3,[1,2,Fraccion.new(3,4), Fraccion.new(1,5), 4,1])
				@d = MatrixDispersa.new(3,3,[0,0,8,0,Fraccion.new(1,2),0,0,0,0],"COO")
				@e = MatrixDispersa.new(3,3,[0,0,0,0,5,0,0,0,0],"CSR")
				@f = Matrix.new(3,3,[1,2,Fraccion.new(3,4), Fraccion.new(1,5), 4,Fraccion.new(5,3),2,1,0])
			end
	
			it "Se debe poder sumar" do
				(@a+@b).to_s.should eq("[3/2 8/3] \n[7/2 19/4] \n")
				(@d+@f).to_s.should eq("[1 2 35/4] \n[1/5 9/2 5/3] \n[2 1 0] \n")
				(@f+@d).to_s.should eq("[1 2 35/4] \n[1/5 9/2 5/3] \n[2 1 0] \n")
				(@d+@e).to_s.should eq("[0 0 8] \n[0 11/2 0] \n[0 0 0] \n")
			end
		
			it "Se debe poder multiplicar" do
				(@a*@c).to_s.should eq("[7/5 10 11/4] \n[19/5 22 25/4] \n")
				(@d*@f).to_s.should eq("[16 8 0] \n[1/10 2 5/6] \n[0 0 0] \n")
				(@e*@d).to_s.should eq("[0 0 0] \n[0 5/2 0] \n[0 0 0] \n")
				(@f*@d).to_s.should eq("[0 1 8] \n[0 2 8/5] \n[0 1/2 16] \n")
			end
			
			it "Se debe poder calcular el max y el min" do
				
				@b.max.should eq("3/4")
				@a.min.should eq("1")
				
				@c.max.should eq("4")
				@c.min.should eq("1/5")

				@d.max.should eq("8")
				@e.max.should eq("5")
			end
		end

