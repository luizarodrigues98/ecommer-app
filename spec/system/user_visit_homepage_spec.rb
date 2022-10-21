require 'rails_helper'
describe "Usuário visita tela inicial" do
  
  it 'e vê galpões' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    visit root_path

    expect(page).to have_content 'E-Commerce App' 
    expect(page).to have_content 'Aeroporto SP' 
    expect(page).to have_content 'Fortaleza' 
  end

  it 'e não existem galpões' do
    fake_response = double("faraday_response", status: 200, body: "[]")
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    visit root_path

    expect(page).to have_content 'Nenhum galpão encontrado'
  end

  it 'e vê detalhes de galpão' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses/5").and_return(fake_response)

    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content 'Galpão GRU - Aeroporto SP'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'Avenida do Aeroporto, 1000 - CEP 15000-000'
    expect(page).to have_content '100000 m2'
    expect(page).to have_content 'Galpão destinado para cargas internacionais'
  end
  it 'e não é possivel carregar o galpão' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    error_response = double("faraday_response", status: 500, body: "{}")
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses/5").and_return(error_response)

    visit root_path
    click_on 'Aeroporto SP'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Não foi possível carregar o galpão'

  end
  
end
