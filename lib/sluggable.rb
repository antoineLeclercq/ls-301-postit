module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
  end

  def to_param
    slug
  end

  def generate_slug!
    slug = to_slug(sluggable_attribute)
    object = self.class.find_by(slug: slug)
    counter = 2

    while object && object != self
      slug = append_suffix(slug, counter)
      object = self.class.find_by(slug: slug)
      counter += 1
    end

    self.slug = slug
  end

  def to_slug(name)
    new_slug = name.gsub(/[^[:alnum:]\- ]/, '').downcase
    new_slug.gsub(/ +/, '-')
  end

  def append_suffix(slug, counter)
    slug_arr = slug.split('-')
    return slug_arr.join('-') << "-#{counter}" if counter == 2

    slug_arr.pop
    slug_arr.push counter
    slug_arr.join('-')
  end
end
