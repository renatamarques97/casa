# Helper methods for new case contact form
module CaseContactsHelper
  def duration_minutes_select(form, case_contact)
    minute_options = build_minute_options

    form.select :duration_minutes,
      options_from_collection_for_select(
        minute_options,
        "value",
        "label",
        case_contact.duration_minutes&.remainder(60)
      ), {},
      class: "custom-select"
  end

  def duration_hours_select(form, case_contact)
    hour_options = build_hour_options

    form.select :duration_hours,
      options_from_collection_for_select(
        hour_options,
        "value",
        "label",
        case_contact.duration_minutes&.div(60)
      ),
      {},
      class: "custom-select"
  end

  private

  def build_minute_options
    durations = []

    # Generate 15, 30, 45 minute intervals
    4.times do |i|
      duration = i * 15
      durations.push(OpenStruct.new(value: duration, label: "#{duration} minutes"))
    end

    durations
  end

  def build_hour_options
    durations = []

    # Generate 0 through 23 hour intervals
    24.times do |i|
      duration = i
      durations.push(OpenStruct.new(value: duration, label: "#{duration} #{"hour".pluralize(i)}"))
    end

    durations
  end
end
