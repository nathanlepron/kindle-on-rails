class HomeController < ApplicationController
    def index
        @best_borrows = get_best_borrows
        @current_borrows = get_current_borrows
    end
end
