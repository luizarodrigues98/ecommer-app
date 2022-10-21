class Warehouse 
  attr_accessor :id, :name, :code, :cep, :address, :city, :description, :area

  def initialize(id:, name:, code:, cep:, address:, city:, description:, area:)
    @id = id
    @name = name
    @code = code 
    @cep = cep
    @address = address
    @city = city
    @description = description
    @area = area
  end
  def self.all
    warehouses = []
    response = Faraday.get('http://localhost:4000/api/v1/warehouses')
    if response.status == 200
      data = JSON.parse(response.body)
      data.each do |d|
        warehouses << Warehouse.new(id: d["id"], name: d["name"], code: d["code"], cep: d["cep"], 
          address: d["address"] , city: d["city"], description: d["description"], area: d["area"])
      end
    end
    warehouses
  end

end