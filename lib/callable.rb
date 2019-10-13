module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args, &block)
      new(*args).call(&block)
    end
  end

  def call
    raise NotImplementedError
  end
end
