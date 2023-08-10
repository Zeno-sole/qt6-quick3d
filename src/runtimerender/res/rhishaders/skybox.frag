#version 440
#extension GL_GOOGLE_include_directive : enable

#ifndef QSSG_ENABLE_RGBE_LIGHT_PROBE
#define QSSG_ENABLE_RGBE_LIGHT_PROBE 0
#endif

#include "../effectlib/tonemapping.glsllib"

layout(location = 0) out vec4 fragOutput;

layout(std140, binding = 0) uniform buf {
    mat3 viewMatrix;
    mat4 inverseProjection;
    mat3 orientation;
    vec4 skyboxProperties;
} ubuf;

// skyboxProperties
// x: adjustY
// y: exposure
// z: blurAmount
// w: maxMipLevel

layout(location = 0) in vec3 eye_direction;
layout(binding = 1) uniform samplerCube skybox_image;

void main()
{
    vec3 eye = normalize(eye_direction);
    float mipLevel = mix(0.0, ubuf.skyboxProperties.w, ubuf.skyboxProperties.z);
    vec4 color = textureLod(skybox_image, eye, mipLevel);
#if QSSG_ENABLE_RGBE_LIGHT_PROBE
    color = vec4(color.rgb * pow(2.0, color.a * 255.0 - 128.0), 1.0);
#endif

    fragOutput = vec4(qt_tonemap(qt_exposure(color.rgb, ubuf.skyboxProperties.y)), 1.0);
}
