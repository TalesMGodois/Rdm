require 'roo'

module DB

	table = Roo::Spreadsheet.open("sheets/dados_economicos.xlsx")

	SELIC = table.sheet('Selic_Otimizado')
	PIB = table.sheet('Pib_Otimizado')
	SELIC = table.sheet('IPCA_Otimizado')
	SELIC = table.sheet('Dolar_Otimizado')


end