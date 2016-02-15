require 'roo'
load 'lib/db/AssociationRules.rb'


module DB



	SELIC	= "S"
	IPCA 	= "I"
	DOLAR  	= "D"

	
	
	pib_ot = Hash.new()
	ipca_ot = Hash.new()
	dolar_ot = Hash.new()

	

	def self.simplify
		indicadores = [SELIC,IPCA,DOLAR]

		table = Roo::Spreadsheet.open("lib/db/sheets/Dados_Tabelados.xlsx")


		data_table = Hash.new()

		data_table[:selic]   = table.sheet('Selic_Otimizado')
		selic = self.getArray(data_table[:selic])

		data_table[:ipca] 	= table.sheet('IPCA_Otimizado')
		ipca  = self.getArray(data_table[:ipca])
		
		data_table[:dolar]   = table.sheet('Dolar_Otimizado')
		dolar = self.getArray(data_table[:dolar])

		data = Hash.new

		data[:selic] = selic
		data[:ipca] = ipca
		data[:dolar] = dolar

		finalTable = self.traduct(data)

		rAssociation = AssociationRules.new(finalTable)
		# return puts rAssociation.countTogether(SELIC,DOLAR)
		
		data = Hash.new

		for i in 0..indicadores.length - 1
			unless i == indicadores.length - 1 
				data["#{indicadores[i]} -- #{indicadores[i+1]}"] = Hash.new
				data["#{indicadores[i]} -- #{indicadores[i+1]}"][:suport] = rAssociation.getSuport(indicadores[i],indicadores[i+1])
				data["#{indicadores[i]} -- #{indicadores[i+1]}"][:confidence] = rAssociation.getConfidence(indicadores[i],indicadores[i+1])
			else
				data["#{indicadores[0]} -- #{indicadores[i]}"] = Hash.new
				data["#{indicadores[0]} -- #{indicadores[i]}"][:suport]= rAssociation.getSuport(indicadores[0],indicadores[i])
				data["#{indicadores[0]} -- #{indicadores[i]}"][:confidence]= rAssociation.getConfidence(indicadores[0],indicadores[i])

			end
		end
		puts data

	end

	def self.getArray(sheet)

		if sheet.class == Roo::Excelx 
			hs = Hash.new()

			months = sheet.column(1)

			years = sheet.row(1)
			aux = years.size() - 1

			for i in 1..aux
				data = sheet.column(i +1)
				data.shift()
				j = 0
				data.each do |item|
					j = j+1
					hs["#{months[j]}-#{years[i]}"] = item
				end
			end

			# return hs
			return self.each_modify(hs)
		else
			return "not a excel file"
		end
	end

	def self.modify(ant,prox)
		if ant >= prox
			return 1
		else
			return 0
		end
	end

	def self.each_modify(hash)
		hash_simple = Hash.new
		aux = 0

		hash.each do |k,v|
			hash_simple[k] =self.modify(aux,v)#
			aux = v 			
		end

		return hash_simple
	end

	def self.traduct(data)
		selic = data[:selic]
		ipca = data[:ipca]
		dolar = data[:dolar]

		final_table = Hash.new()

		selic.keys.each do |k|
			final_table[k] = Array.new()
		end

		selic.each do |k,v|
			final_table[k].push("S") if v == 1

		end

		ipca.each do |k,v|
			final_table[k].push("I") if v == 1

		end

		dolar.each do |k,v|
			final_table[k].push("D") if v == 1

		end

		aux = 0
		final_table.each do |k,v|
			if v.size ==0
				aux = aux +1
			end
		end
		return final_table
	end
	
end


DB::simplify()
