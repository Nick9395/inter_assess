# 年月（YYYY-MM）を date（その月の1日）として保存する
module YearMonthAttributable
  extend ActiveSupport::Concern

  class_methods do
    def year_month_accessor(*names)
      names.each do |name|
        define_method(:"#{name}=") do |value|
          super(parse_year_month(value))
        end
      end
    end
  end

  private

  def parse_year_month(value)
    return if value.blank?
    return value if value.is_a?(Date) || value.is_a?(Time)

    if value.is_a?(String) && value.match?(/\A\d{4}-\d{2}\z/)
      Date.strptime("#{value}-01", "%Y-%m-%d")
    else
      value
    end
  end
end
