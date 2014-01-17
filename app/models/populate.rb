class Populate
  attr_reader :api, :scraper, :company, :location, :person, :industry

  DOMAINS = ["flat"]

  def initialize
  	@api = Api.new
    # @scraper = Scraper.new
  end
  
  def run
    create_company
    create_industry
    create_location
    create_people
  end

  def create_company
    @api.find_company(DOMAINS.last)
    @company = Company.create(:name => @api.company_name, :linkedin_id => @api.company_id)
  end

  def create_industry    
    @industry = Industry.create(:name => @api.company_industry)
    @industry.companies << @company
    # @company.industries << @industry
  end

  def create_location
    @location = Location.create(:postalcode => @api.company_postalcode)
    @company.locations << @location
    # @location.companies << @company
  end

  def create_people
    @person = Person.create(:firstname => @api.firstname, :lastname => @api.lastname,
    :linkedin_id => @api.linkedin_id, :linkedin_url => @api.linkedin_url)
  end

end

