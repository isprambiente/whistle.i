module ApplicationHelper
  # Print a box with a message.
  # @param message [String] text of the message
  # @param style [String] css class of the box, default empty string
  # @param fa [String] Name of the 'font-awesome' icon, default 'info'
  # @return [String] preformed html code
  def alert_box(message, style = '', fa: 'info')
    ret = <<~EOF
      <div class='callout #{style}' data-closable>
        <span class="float-left fa fa-#{fa}"></span>
        #{message}
        <button class='close-button' aria-label='Dismiss alert' type='button' data-close>
          <span aria-hidden='true'>&times;</span>
        </button>
      </div>
    EOF
    return ret.html_safe
  end

  def icon(icon=nil, text=nil)
    return "<i class='fas fa-#{icon}'></i> #{text}".html_safe
  end
end
