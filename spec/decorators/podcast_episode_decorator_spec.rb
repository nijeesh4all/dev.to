require "rails_helper"

RSpec.describe PodcastEpisodeDecorator, type: :decorator do
  describe "#comments_to_show_count" do
    it "returns 25 if does not have a discuss tag" do
      pe = build(:podcast_episode)
      expect(pe.decorate.comments_to_show_count).to eq(25)
    end

    it "returns 75 if it does have a discuss tag" do
      pe = build(:podcast_episode, tag_list: ["discuss"])
      expect(pe.decorate.comments_to_show_count).to eq(75)
    end
  end

  describe "#cached_tag_list_array" do
    it "returns no tags if the tag list is empty" do
      pe = build(:podcast_episode, tag_list: [])
      expect(pe.decorate.cached_tag_list_array).to be_empty
    end

    it "returns tag list" do
      pe = build(:podcast_episode, tag_list: ["discuss"])
      expect(pe.decorate.cached_tag_list_array).to eq(pe.tag_list)
    end
  end

  describe "#readable_publish_date" do
    it "returns empty string if the episode does not have a published_at" do
      pe = build(:podcast_episode, published_at: nil)
      expect(pe.decorate.readable_publish_date).to be_empty
    end

    it "returns the correct date for a same year publication" do
      published_at = Time.current
      pe = build(:podcast_episode, published_at: published_at)
      expect(pe.decorate.readable_publish_date).to eq(published_at.strftime("%b %e"))
    end

    it "returns the correct date for a publication within a different year" do
      published_at = 2.years.ago
      pe = build(:podcast_episode, published_at: published_at)
      expect(pe.decorate.readable_publish_date).to eq(published_at.strftime("%b %e '%y"))
    end
  end

  describe "#published_timestamp" do
    it "returns empty string if the episode does not have a published_at" do
      pe = build(:podcast_episode, published_at: nil)
      expect(pe.decorate.published_timestamp).to be_empty
    end

    it "returns the correct date for a published episode" do
      published_at = Time.current
      pe = build(:podcast_episode, published_at: published_at)
      expect(pe.decorate.published_timestamp).to eq(published_at.utc.iso8601)
    end
  end
end
