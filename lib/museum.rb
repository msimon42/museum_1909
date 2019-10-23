class Museum
  attr_reader :name, :exhibits, :patrons, :patrons_of_exhibits

  def initialize(name)
    @name = name
    @exhibits = Array.new
    @patrons = Array.new
  end

  def generate_exhibits
    @patrons_of_exhibits = Hash.new
    @exhibits.each do |exhibit|
      @patrons_of_exhibits[exhibit] = []
    end
    @patrons_of_exhibits
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def admit(patron)
    @patrons << patron
    exhibits = self.recommend_exhibits(patron)
    exhibits.sort_by {|exhibit| exhibit.cost}
    exhibits.each do |exhibit|
      if exhibit.cost <= patron.spending_money
        @patrons_of_exhibits[exhibit] << patron
        patron.spending_money -= exhibit.cost
        @revenue += exhibit.cost
      end
    end      
  end

  def recommend_exhibits(patron)
    @exhibits.find_all {|exhibit| patron.interests.include?(exhibit.name)}
  end

  def patrons_by_exhibit_interest
    interest_list = Hash.new
    @exhibits.each do |exhibit|
      interest_list[exhibit] = []
      @patrons.each do |patron|
        if self.recommend_exhibits(patron).include?(exhibit)
          interest_list[exhibit] << patron
        end
      end
    end
    interest_list
  end

end
