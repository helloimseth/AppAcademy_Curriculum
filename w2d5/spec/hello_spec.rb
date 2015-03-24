require 'rspec'
require 'hello'

describe "#my_transpose" do
  it "returns 'Hello, World!'" do
    expect(my_transpose).to eq("Hello, World!")
  end

end
