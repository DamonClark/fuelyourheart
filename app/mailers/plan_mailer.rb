class PlanMailer < ApplicationMailer
  def send_plan(email, plan)
    @plan = plan
    attachments["training_plan.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: "plans/show.pdf.erb", layout: false)
    )
    mail(to: email, subject: "Your Training Plan from FuelYourHeart")
  end
end
