class AssociationRules 
	
	@tidTables 		= Hash.new
	@suports 		= Hash.new
	@confidences 	= Hash.new
	@SIZE = 0
	@DATA = Hash.new


	def initialize(args)
		@tidTables = args if args.class == Hash
		@SIZE = @tidTables.size()
	end


	def tidTables
		return @tidTables
	end


	def getBiggestSuport
		return 0
	end

	def countTogether(a,b)
		count = 0
		@tidTables.each do |k,v|
			an = false
			bn = false
			v.each do |item|
				if item == a
					an = true
				elsif item == b
					bn = true
				end
			end
			if an ==true and bn == true
				count = count + 1
			end
		end
		return count
	end

	def countElement(a)
		count = 0 
		@tidTables.each do |k,v|
			v.each do |item|
				if item == a
					count = count + 1 
				end
			end
			
		end
		return count
	end


	def getSuport(a,b)
		#rule a -> b
		#a e b juntos / total de transacoes
		count = countTogether(a,b)
		puts @SIZE
		puts count
		return count/@SIZE.to_f
		
	end

	def getConfidence(a,b)
		# rule a -> b
		#a / a e b juntos

		result = 0.0
		result = countTogether(a,b)/countElement(a).to_f
		return result
	end
	
end