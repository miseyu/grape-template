class ApplicationEntity < Grape::Entity

  def self.inherited(child)
    child.format_with(:response_format_date) do |dt|
      if dt.present?
        dt.strftime "%Y-%m-%d %H:%M:%S"
      end
    end
    child.format_with(:response_format_time) do |dt|
      if dt.present?
        dt.strftime "%H:%M"
      end
    end
    child.root 'items'
  end

end
