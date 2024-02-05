class Alert < ApplicationRecord
  after_save :send_email_if_triggered

  def send_email_if_triggered
    if status == 'triggered'
      # Implement logic to send email using the chosen email service
      # Example using Gmail SMTP
      Mail.deliver do
        from    'focussedprep@gmail.com'
        to      'imshivam125@gmail.com'
        subject 'Price Alert Triggered'
        body    'The target price has been reached!'
      end
    end
  end
end
