
class OrderSerializer
  def initialize(order:)
    @order = order
  end

  attr_accessor :order

  def serialized_hash
    {
      number: order.number,
      channel: "store",
      item_total: order.item_total,
      adjustment_total: order.adjustment_total,
      total: order.total,
      payment_total: order.payment_total,
      currency: order.currency,
      state: order.state,
      shipping_method: "",
      created_at: order.created_at,
      updated_at: order.updated_at,
      payment_state: order.payment_state,
      shipment_state: order.shipment_state,
      created_by: order&.created_by&.email || order.email,
      billing_address: bill_address,
      shipping_address: ship_address,
      items: line_items
    }
  end

  private

  # TODO: move into separate serializer
  def ship_address
    return {} if order.ship_address.nil?
    {
      company: order.ship_address.company,
      first_name: order.ship_address.firstname,
      last_name: order.ship_address.lastname,
      email: order.ship_address&.user&.email,
      phone: order.ship_address.phone,
      street: "#{order.ship_address.address1}, #{order.ship_address.address2}",
      zip: order.ship_address.zipcode,
      city: order.ship_address.city,
      country: order.ship_address.country.iso
    }
  end

  def bill_address
    return {} if order.bill_address.nil?

    {
      company: order.bill_address.company,
      first_name: order.bill_address.firstname,
      last_name: order.bill_address.lastname,
      email: order.bill_address&.user&.email,
      phone: order.bill_address.phone,
      street: "#{order.bill_address.address1}, #{order.bill_address.address2}",
      zip: order.bill_address.zipcode,
      city: order.bill_address.city,
      country: order.bill_address.country.iso,
      vat_id: ""
    }
  end

  def line_items
    return [] if order.line_items.empty?

    order.line_items.map do |item|
      {
        sku: item.variant.sku,
        quantity: item.quantity,
        price: item.price,
        final_price: item.total,
        size: 0
      }
    end
  end
end
