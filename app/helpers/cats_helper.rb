module CatsHelper
  def cat_unique_keys(cats, key)
    cats.map { |cat| cat[key].strip }.uniq
  end
end
