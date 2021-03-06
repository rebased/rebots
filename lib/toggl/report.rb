 module Toggl 
  class Report < Base
    attr_reader :user, :entries_summary

    def initialize(user:, entries_summary:)
      @user = user
      @entries_summary = entries_summary
    end

    def prepare!
      {
        name: user,
        entries_summary: missing_day_entries
      }
    end

    private

    def missing_day_entries
      totals_with_days.reject do |day, value| 
        %w[Saturday Sunday].include?(day) || !value.eql?(nil)
      end
    end

    def totals_with_days
      Hash[start_day.zip(entries_summary)]
    end
  end
end
