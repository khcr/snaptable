module Snaptable 
  module Helpers
    module ButtonsHelper

      def add_button
        link_to t("table.buttons.add"), request.path + "/new", class: "add"
      end

      def show_button
        link_to t("table.buttons.show"), "#", class: "show"
      end

      def edit_button
        link_to t("table.buttons.edit"), "#", class: "edit"
      end

      def delete_button
        link_to t("table.buttons.delete"), "#", method: :delete, class: "delete", data: { confirm: "Etes-vous sûr de vouloir supprimer cette entrée ?" } 
      end

      def add_button?
        !Snaptable.use_permission || rights?(:create, params[:controller])
      end

      def edit_button?
        !Snaptable.use_permission || rights?(:update, params[:controller])
      end

      def show_button?
        !Snaptable.use_permission || rights?(:read, params[:controller])
      end

      def delete_button?
        !Snaptable.use_permission || rights?(:destroy, params[:controller])
      end

    end
  end
end