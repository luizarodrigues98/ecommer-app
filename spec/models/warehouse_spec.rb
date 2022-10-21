require 'rails_helper'

describe 'Warehouse' do
  
  context ".all" do
    it 'deve retornar todos os galpões' do
      json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
      fake_response = double("faraday_response", status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
  
      result = Warehouse.all

      expect(result.length).to eq 2
      expect(result[0].name).to eq 'Aeroporto SP'
      expect(result[0].code).to eq 'GRU'
      expect(result[0].id).to eq 1
      expect(result[0].city).to eq 'Guarulhos'
      expect(result[0].area).to eq 100000
      expect(result[0].address).to eq 'Avenida do Aeroporto, 1000'
      expect(result[0].description).to eq "Galpão destinado para cargas internacionais"
      
      expect(result[1].name).to eq 'Fortaleza'
      expect(result[1].code).to eq 'FTZ'
      expect(result[1].id).to eq 2
      expect(result[1].city).to eq 'Fortaleza'
      expect(result[1].area).to eq 5000
      expect(result[1].address).to eq "Av do Museo, 999"
      expect(result[1].description).to eq "Galpão de fortaleza"
    end

    it 'deve retornar retornar vazio se a API está indisponícel' do
      fake_response = double("faraday_response", status: 500, body: "{}")
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

      result = Warehouse.all
      expect(result).to eq []
    end
  end
end
