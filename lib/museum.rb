class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = Array.new
    @patrons = Array.new
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def admit(patron)
    @patrons << patron
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
