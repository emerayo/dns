# frozen_string_literal: true

class V1::DnsServersController < ApplicationController
  def create
    @dns_server = DnsServer.new(dns_server_params)

    if @dns_server.save
      render json: @dns_server, status: :ok
    else
      render json: { errors: { messages: @dns_server.errors } },
             status: :unprocessable_entity
    end
  end

  private

  def dns_server_params
    params.require(:dns_server).permit(:ip, hostnames_attributes: [:domain])
  end
end
