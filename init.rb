require 'redmine'
require 'dispatcher'
require 'redmine_spent_time_column/hooks'

Dispatcher.to_prepare do
  Issue.send(:include, RedmineSpentTimeColumn::Patches::IssuePatch) unless Issue.include?(RedmineSpentTimeColumn::Patches::IssuePatch)
  Query.send(:include, RedmineSpentTimeColumn::Patches::QueryPatch) unless Query.include?(RedmineSpentTimeColumn::Patches::QueryPatch)
  QueriesHelper.send(:include, RedmineSpentTimeColumn::Patches::QueriesHelperPatch) unless QueriesHelper.include?(RedmineSpentTimeColumn::Patches::QueriesHelperPatch)
end

Redmine::Plugin.register :redmine_spent_time_column do
  name 'Redmine Spent Time Column'
  author 'Jan Schulz-Hofen, Planio GmbH'
  description 'This plugin adds a spent time column to issue lists.'
  version '2.0.0-devel'

  settings :default => {
    'show_bottom_summary_line_on_issuelists' => '0',
    'show_bottom_summary_line_estimated_hours' => '1',
    'show_bottom_summary_line_spent_hours' => '1',
    'show_bottom_summary_line_calculated_spent_hours' => '1',
    'show_bottom_summary_line_divergent_hours' => '1',
    'show_bottom_summary_line_calculated_remaining_hours' => '1',
    'show_bottom_summary_line_remaining_hours' => '1',
    'enable_spent_hours_column' => '1',
    'enable_calculated_spent_hours_column' => '0',
    'enable_divergent_hours_column' => '0',
    'enable_calculated_remaining_hours_column' => '0',
    'enable_remaining_hours_column' => '0'
  }, :partial => 'settings/spent_time_column_settings'
end
