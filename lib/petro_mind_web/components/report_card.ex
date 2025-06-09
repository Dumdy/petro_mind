# defmodule PetroMindWeb.ReportCard do
#   use Phoenix.Component

#   attr :report, :map, required: true

#   def report_card(assigns) do
#     ~H"""
#     <div class="bg-white shadow rounded-lg overflow-hidden relative">
#       <!-- PDF Download Button -->
#       <div class="absolute top-4 right-4">
#         <.link
#           href={~p"/reports/#{@report.id}/pdf"}
#           class="inline-flex items-center px-3 py-1.5 border border-gray-300 text-sm rounded-md bg-white hover:bg-gray-50"
#         >
#           Download PDF
#         </.link>
#       </div>

#       <div class="px-6 py-4 bg-gray-50 border-b">
#         <h3 class="text-lg font-medium text-gray-900">
#           Report created: {Calendar.strftime(@report.inserted_at, "%B %d, %Y at %I:%M %p UTC")}
#         </h3>
#       </div>

#       <div class="p-6">
#         <div class="grid grid-cols-2 gap-4 sm:grid-cols-4">
#           <div>
#             <dt class="text-sm font-medium text-gray-500">Report Type</dt>
#             <dd class="mt-1 text-sm text-gray-900 capitalize">
#               {String.replace(@report.report_type, "_", " ")}
#             </dd>
#           </div>
#           <div>
#             <dt class="text-sm font-medium text-gray-500">Value</dt>
#             <dd class="mt-1 text-sm text-gray-900">{@report.value}</dd>
#           </div>
#           <div>
#             <dt class="text-sm font-medium text-gray-500">Threshold</dt>
#             <dd class="mt-1 text-sm text-gray-900">{@report.threshold}</dd>
#           </div>
#           <div>
#             <dt class="text-sm font-medium text-gray-500">Status</dt>
#             <dd class="mt-1">
#               <span class={[
#                 "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium",
#                 if(@report.status == "Normal",
#                   do: "bg-green-100 text-green-800",
#                   else: "bg-red-100 text-red-800"
#                 )
#               ]}>
#                 {@report.status}
#               </span>
#             </dd>
#           </div>
#         </div>

#         <div class="mt-4">
#           <.link
#             navigate={~p"/reports/#{@report.id}"}
#             class="text-indigo-600 hover:text-indigo-500 text-sm font-medium"
#           >
#             View Details →
#           </.link>
#         </div>
#       </div>
#     </div>
#     """
#   end
# end
