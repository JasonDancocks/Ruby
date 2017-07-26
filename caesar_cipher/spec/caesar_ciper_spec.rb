require "caesar_cipher"

describe caesar_cipher("test",0) do 
	context "given a string of 4 chars" do
		it "splits into 4 letters" do
			expect(caesar_cipher("test",0)).to eql(["t","e","s","t"])
		end
	end
end
