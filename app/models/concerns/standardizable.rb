module Standardizable
  extend ActiveSupport::Concern

  def div
    [self.class.to_s, '_', id].join
  end

  def full_div
    ['#', self.class.to_s, '_', id].join
  end
end
