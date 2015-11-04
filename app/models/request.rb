class Request < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true

  DEPARTMENT_SALES     = "Sales"
  DEPARTMENT_TECHNICAL = "Technical"
  DEPARTMENT_MARKETING = "Marketing"

  DEPARTMENTS = [DEPARTMENT_SALES, DEPARTMENT_TECHNICAL, DEPARTMENT_MARKETING]

  after_initialize :set_defaults

  def self.search(term)
    if term
      where(["LOWER(name) LIKE :search_term OR LOWER(email) LIKE :search_term
               OR LOWER(message) LIKE :search_term", {search_term: "%#{term}%"}])
    else
      all
    end
  end

  private

  def set_defaults
    self.done ||= false
  end

end
