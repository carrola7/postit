module Sluggable
  extend ActiveSupport::Concern

  def to_param
    self.slug
  end

  def generate_slug(field)
    slug = to_slug(self.send field)
    post = Post.find_by slug: slug
    count = 2
    while post && post != self
      slug = append_suffix(slug, count)
      post = Post.find_by slug: slug
      count += 1
    end
    self.slug = slug
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end

  def slug=(str)
    @slug = str
  end

end