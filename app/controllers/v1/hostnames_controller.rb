# frozen_string_literal: true

class V1::HostnamesController < ApplicationController
  def search
    search = Search.new(params.fetch(:page, 1), params[:included_domains], params[:excluded_domains])
    render json: search.parsed_hosts
  end
end
