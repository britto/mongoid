class Post
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Versioning
  include Mongoid::Timestamps
  field :title
  field :content
  referenced_in :person
  referenced_in :author, :foreign_key => :author_id, :class_name => "User"
  references_and_referenced_in_many :tags
  references_many :videos, :validate => false

  scope :recent, where(:created_at => { "$lt" => Time.now, "$gt" => 30.days.ago })
  scope :posting, where(:content.in => [ "Posting" ])

  validates_format_of :title, :without => /\$\$\$/

  class << self
    def old
      where(:created_at => { "$lt" => 30.days.ago })
    end
  end
end
