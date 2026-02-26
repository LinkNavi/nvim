-- lua/snippets/vulkan.lua
-- Place at: ~/.config/nvim/lua/snippets/vulkan.lua
-- Then add to your LSP config: require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {

  -- VkInstance creation
  s("vkinst", fmt([[
VkApplicationInfo appInfo = {{}};
appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
appInfo.pApplicationName = "{}";
appInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
appInfo.pEngineName = "{}";
appInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0);
appInfo.apiVersion = VK_API_VERSION_1_3;

VkInstanceCreateInfo createInfo = {{}};
createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
createInfo.pApplicationInfo = &appInfo;

VkInstance instance;
if (vkCreateInstance(&createInfo, NULL, &instance) != VK_SUCCESS) {{
    fprintf(stderr, "Failed to create Vulkan instance\n");
    {}
}}
]], { i(1, "MyApp"), i(2, "NoEngine"), i(3, "return -1") })),

  -- VkDevice creation
  s("vkdev", fmt([[
float queuePriority = 1.0f;
VkDeviceQueueCreateInfo queueCreateInfo = {{}};
queueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
queueCreateInfo.queueFamilyIndex = {};
queueCreateInfo.queueCount = 1;
queueCreateInfo.pQueuePriorities = &queuePriority;

VkPhysicalDeviceFeatures deviceFeatures = {{}};

VkDeviceCreateInfo deviceCreateInfo = {{}};
deviceCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
deviceCreateInfo.pQueueCreateInfos = &queueCreateInfo;
deviceCreateInfo.queueCreateInfoCount = 1;
deviceCreateInfo.pEnabledFeatures = &deviceFeatures;

VkDevice device;
if (vkCreateDevice({}, &deviceCreateInfo, NULL, &device) != VK_SUCCESS) {{
    fprintf(stderr, "Failed to create logical device\n");
    {}
}}
]], { i(1, "queueFamilyIndex"), i(2, "physicalDevice"), i(3, "return -1") })),

  -- VkRenderPass
  s("vkrp", fmt([[
VkAttachmentDescription colorAttachment = {{}};
colorAttachment.format = {};
colorAttachment.samples = VK_SAMPLE_COUNT_1_BIT;
colorAttachment.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
colorAttachment.storeOp = VK_ATTACHMENT_STORE_OP_STORE;
colorAttachment.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
colorAttachment.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
colorAttachment.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
colorAttachment.finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;

VkAttachmentReference colorAttachmentRef = {{}};
colorAttachmentRef.attachment = 0;
colorAttachmentRef.layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL;

VkSubpassDescription subpass = {{}};
subpass.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS;
subpass.colorAttachmentCount = 1;
subpass.pColorAttachments = &colorAttachmentRef;

VkRenderPassCreateInfo renderPassInfo = {{}};
renderPassInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
renderPassInfo.attachmentCount = 1;
renderPassInfo.pAttachments = &colorAttachment;
renderPassInfo.subpassCount = 1;
renderPassInfo.pSubpasses = &subpass;

VkRenderPass renderPass;
if (vkCreateRenderPass({}, &renderPassInfo, NULL, &renderPass) != VK_SUCCESS) {{
    fprintf(stderr, "Failed to create render pass\n");
    {}
}}
]], { i(1, "swapChainImageFormat"), i(2, "device"), i(3, "return -1") })),

  -- VkShaderModule
  s("vksm", fmt([[
VkShaderModuleCreateInfo shaderInfo = {{}};
shaderInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
shaderInfo.codeSize = {};
shaderInfo.pCode = (const uint32_t*){};

VkShaderModule {};
if (vkCreateShaderModule({}, &shaderInfo, NULL, &{}) != VK_SUCCESS) {{
    fprintf(stderr, "Failed to create shader module\n");
    {}
}}
]], { i(1, "codeSize"), i(2, "code"), i(3, "shaderModule"), i(4, "device"), i(5, "shaderModule"), i(6, "return -1") })),

  -- VkCommandBuffer begin/end
  s("vkcb", fmt([[
VkCommandBufferBeginInfo beginInfo = {{}};
beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
beginInfo.flags = {};

vkBeginCommandBuffer({}, &beginInfo);

{}

vkEndCommandBuffer({});
]], { i(1, "0"), i(2, "commandBuffer"), i(3, "// commands"), i(4, "commandBuffer") })),

  -- VkBuffer creation
  s("vkbuf", fmt([[
VkBufferCreateInfo bufferInfo = {{}};
bufferInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
bufferInfo.size = {};
bufferInfo.usage = {};
bufferInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;

VkBuffer {};
if (vkCreateBuffer({}, &bufferInfo, NULL, &{}) != VK_SUCCESS) {{
    fprintf(stderr, "Failed to create buffer\n");
    {}
}}
]], { i(1, "size"), i(2, "VK_BUFFER_USAGE_VERTEX_BUFFER_BIT"), i(3, "buffer"), i(4, "device"), i(5, "buffer"), i(6, "return -1") })),

  -- VkDescriptorSetLayout
  s("vkdsl", fmt([[
VkDescriptorSetLayoutBinding {};
{}.binding = {};
{}.descriptorType = {};
{}.descriptorCount = 1;
{}.stageFlags = {};
{}.pImmutableSamplers = NULL;

VkDescriptorSetLayoutCreateInfo layoutInfo = {{}};
layoutInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
layoutInfo.bindingCount = 1;
layoutInfo.pBindings = &{};

VkDescriptorSetLayout descriptorSetLayout;
if (vkCreateDescriptorSetLayout({}, &layoutInfo, NULL, &descriptorSetLayout) != VK_SUCCESS) {{
    fprintf(stderr, "Failed to create descriptor set layout\n");
    {}
}}
]], {
    i(1, "binding"),
    f(function(args) return args[1][1] end, {1}),
    i(2, "0"),
    f(function(args) return args[1][1] end, {1}),
    i(3, "VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER"),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    i(4, "VK_SHADER_STAGE_VERTEX_BIT"),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    i(5, "device"),
    i(6, "return -1"),
  })),

  -- VkResult check macro style
  s("vkcheck", fmt([[
if ({} != VK_SUCCESS) {{
    fprintf(stderr, "{} failed\n");
    {}
}}
]], { i(1, "vkSomeFunction(...)"), i(2, "Operation"), i(3, "return -1") })),

  -- Render loop begin
  s("vkframe", fmt([[
// Begin frame
uint32_t imageIndex;
vkAcquireNextImageKHR({}, {}, UINT64_MAX, {}, VK_NULL_HANDLE, &imageIndex);

VkSubmitInfo submitInfo = {{}};
submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;

VkSemaphore waitSemaphores[] = {{{}}};
VkPipelineStageFlags waitStages[] = {{VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT}};
submitInfo.waitSemaphoreCount = 1;
submitInfo.pWaitSemaphores = waitSemaphores;
submitInfo.pWaitDstStageMask = waitStages;
submitInfo.commandBufferCount = 1;
submitInfo.pCommandBuffers = &{}[imageIndex];

VkSemaphore signalSemaphores[] = {{{}}};
submitInfo.signalSemaphoreCount = 1;
submitInfo.pSignalSemaphores = signalSemaphores;

vkQueueSubmit({}, 1, &submitInfo, VK_NULL_HANDLE);

VkPresentInfoKHR presentInfo = {{}};
presentInfo.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
presentInfo.waitSemaphoreCount = 1;
presentInfo.pWaitSemaphores = signalSemaphores;

VkSwapchainKHR swapChains[] = {{{}}};
presentInfo.swapchainCount = 1;
presentInfo.pSwapchains = swapChains;
presentInfo.pImageIndices = &imageIndex;

vkQueuePresentKHR({}, &presentInfo);
]], {
    i(1, "device"), i(2, "swapChain"), i(3, "imageAvailableSemaphore"),
    i(4, "imageAvailableSemaphore"), i(5, "commandBuffers"),
    i(6, "renderFinishedSemaphore"), i(7, "graphicsQueue"),
    i(8, "swapChain"), i(9, "presentQueue"),
  })),

})
