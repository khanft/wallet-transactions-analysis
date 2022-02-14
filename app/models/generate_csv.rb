require "csv"
module GenerateCsv
  extend ActiveSupport::Concern

  class_methods do
    def generate_csv
      CSV.generate(headers: true) do |csv|
        headers = self.attribute_names + ["tags"]
        csv << headers
        

        all.each do |record|
          values = record.attributes.values + [record.categories.map(&:name).join("|")]
          csv << values
        end
      end
    end
  end
end