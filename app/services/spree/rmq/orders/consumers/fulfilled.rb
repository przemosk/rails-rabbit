
module Spree
  module Rmq
    module Orders
      module Consumers
        class Fulfilled
          prepend Spree::ServiceModule::Base

          def call(payload:)
            return failure('empty shipments') if payload["shipments"].empty?

            payload["shipments"].each do |shipment|
              item = find_shipment(number: shipment["number"])

              return failure("shipment with number #{shipment["number"]} not found") if item.nil?

              result = update_shipment_state(shipment: item, state: shipment["state"])

              if result.success?
                item.order.updater.update_shipment_state
                item.order.updater.persist_totals
              end
            end

            success(true)
          end

          private

          def find_shipment(number:)
            Spree::Shipment.find_by(number: number)
          end

          def update_shipment_state(shipment:, state:)
            Spree::Shipments::ChangeState.call(shipment: shipment, state: state)
          end
        end
      end
    end
  end
end
