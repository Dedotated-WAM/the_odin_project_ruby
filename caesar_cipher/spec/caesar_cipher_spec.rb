require "./lib/caesar_cipher"

RSpec.describe "CaesarCipher" do
  let(:cipher) { CaesarCipher.new }

  describe "#translate" do
    it "ciphers a string" do
      expect(cipher.translate("What a string!", 5)).to eq("Bmfy f xywnsl!")
    end

    it "does not affect punctuation" do
      expect(cipher.translate("!!!***...", 5)).to eq("!!!***...")
    end

    it "does not change letter case" do
      expect(cipher.translate("AAaa,BBbb", 1)).to eq("BBbb,CCcc")
    end

    it "does not affect numbers" do
      expect(cipher.translate("1234aa", 1)).to eq("1234bb")
    end

    it "wraps from 'z' to 'a' and 'Z' to 'A'" do
      expect(cipher.translate("zz,ZZ", 1)).to eq("aa,AA")
    end
  end
end
