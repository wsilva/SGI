require 'test_helper'

class IdeiaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  #  test "the truth" do
  #    assert true
  #  end
  test "should not have empty title teaser body" do
    ideia = Ideia.new 
    ideia.user_id = 1
    assert ideia.invalid? 
    assert ideia.errors[:titulo].any?
    assert ideia.errors[:texto].any?
    assert !ideia.save
  end

  test "must belong to a user" do
    ideia = Ideia.new :titulo => "Title", :texto => "Body"
    assert ideia.invalid? 
    assert !ideia.save
  end
  
  test "should not have a state outside boundaries" do
    ideia = Ideia.new :titulo => "Title", :texto => "Body"
    ideia.user_id = 1
    
    ideia.state = -1
    assert !ideia.save
    ideia.state = 'a'
    assert !ideia.save
    ideia.state = 5
    assert !ideia.save
    
    ideia.state = 0   
    assert ideia.save
    ideia.state = 2
    assert ideia.save
    ideia.state = 4   
    assert ideia.save 
  end
end
