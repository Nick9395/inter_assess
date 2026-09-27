module ApplicationHelper
  def auth_label_class
    "block text-sm font-medium text-slate-700"
  end

  def auth_field_class
    "mt-1 block w-full rounded-lg border border-slate-300 bg-white px-3 py-2 text-slate-900 shadow-sm focus:border-slate-500 focus:outline-none focus:ring-1 focus:ring-slate-500"
  end

  def auth_submit_class
    "mt-2 inline-flex w-full justify-center rounded-lg bg-slate-900 px-4 py-2.5 text-sm font-medium text-white hover:bg-slate-800"
  end

  def nav_link_class
    "inline-flex rounded-md border border-white bg-navy px-3 py-0.5 text-sm leading-tight text-white hover:border-gold hover:bg-gold hover:text-navy-deep"
  end

  def primary_button_class
    "inline-flex items-center justify-center rounded-md border border-navy bg-navy px-4 py-2 text-sm text-white hover:border-gold hover:bg-gold hover:text-navy-deep"
  end

  def month_field_value(date)
    date&.strftime("%Y-%m")
  end

  def secondary_button_class
    "inline-flex items-center justify-center rounded-md border border-navy px-4 py-2 text-sm text-navy hover:bg-white"
  end

  def danger_button_class
    "inline-flex items-center justify-center rounded-md border border-red-700 px-4 py-2 text-sm text-red-800 hover:bg-red-50"
  end

  def profile_slot_visible?(entry, index)
    return true if index.zero?
    return true if entry.persisted? || entry.errors.any?

    entry.attributes.except("id", "user_id", "position", "created_at", "updated_at").values.any?(&:present?)
  end
end
