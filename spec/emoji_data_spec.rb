#encoding: UTF-8
require 'spec_helper'

describe EmojiData do
  describe ".all" do
    it "should return an array of all known emoji chars" do
      EmojiData.all.count.should eq(842)
    end
    it "should return all EmojiChar objects" do
      EmojiData.all.all? {|char| char.class == EmojiData::EmojiChar}.should be_true
    end
  end

  describe ".find_by_unified" do
    it "should find the proper EmojiChar object" do
      results = EmojiData.find_by_unified('1f680')
      results.should be_kind_of(EmojiChar)
      results.name.should eq('ROCKET')
    end
    it "should normallise capitalization for hex values" do
      EmojiData.find_by_unified('1f680').should_not be_nil
    end
  end

  describe ".find_by_name" do
    it "returns an array of results" do
      EmojiData.find_by_name('tree').should be_kind_of(Array)
      EmojiData.find_by_name('tree').count.should eq(5)
    end
    it "returns [] if nothing is found" do
      EmojiData.find_by_name('sdlkfjlskdfj').should_not be_nil
      EmojiData.find_by_name('sdlkfjlskdfj').should be_kind_of(Array)
      EmojiData.find_by_name('sdlkfjlskdfj').count.should eq(0)
    end
  end

  describe ".find_by_short_name" do
    it "returns an array of results, downcasing if needed" do
      EmojiData.find_by_short_name('MOON').should be_kind_of(Array)
      EmojiData.find_by_short_name('MOON').count.should eq(13)
    end
    it "returns [] if nothing is found" do
      EmojiData.find_by_short_name('sdlkfjlskdfj').should_not be_nil
      EmojiData.find_by_short_name('sdlkfjlskdfj').should be_kind_of(Array)
      EmojiData.find_by_short_name('sdlkfjlskdfj').count.should eq(0)
    end
  end

  describe ".char_to_unified" do
    it "converts normal emoji to unified codepoint" do
      EmojiData.char_to_unified("👾").should eq('1F47E')
      EmojiData.char_to_unified("🚀").should eq('1F680')
    end
    it "converts double-byte emoji to proper codepoint" do
      EmojiData.char_to_unified("🇺🇸").should eq('1F1FA-1F1F8')
      EmojiData.char_to_unified("#⃣").should eq('0023-20E3')
    end
  end

  # TODO: below is kinda redundant but it is helpful as a helper method so maybe still test
  describe ".unified_to_char" do
    it "converts normal unified codepoints to unicode strings" do
      EmojiData.unified_to_char('1F47E').should eq("👾")
      EmojiData.unified_to_char('1F680').should eq("🚀")
    end
    it "converts doublebyte unified codepoints to unicode strings" do
      EmojiData.unified_to_char('1F1FA-1F1F8').should eq("🇺🇸")
      EmojiData.unified_to_char('0023-20E3').should eq("#⃣")
    end
  end
end