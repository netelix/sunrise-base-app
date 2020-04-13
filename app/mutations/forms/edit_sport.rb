module Forms
  class EditSport < ProcessForm
    required do
      string :category
    end

    optional do
      duck :sport

      string :name_fr, empty: true
      string :name_en, empty: true
      string :name_es, empty: true
    end

    def validate
      validate_presence_of_current_locale_name
    end

    def create?
      !sport.persisted?
    end

    def category_select_options
      [
          [I18n.t('activerecord.sports.categories.cardio'), :cardio],
          [I18n.t('activerecord.sports.categories.body_building'), :body_building],
          [I18n.t('activerecord.sports.categories.well_being'), :well_being],
          [I18n.t('activerecord.sports.categories.dance'), :dance]
      ]
    end

    def execute
      sport.assign_attributes(category: category)
      sport.save!

      save_names(sport)
    end

    def initialize_form
      form.initialize_names(sport)
      form.category = sport.category
    end

    private

    def unpermitted_form_input_names
      %i[sport]
    end
  end
end
