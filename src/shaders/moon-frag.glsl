#version 300 es

// This is a fragment shader. If you've opened this file first, please
// open and read lambert.vert.glsl before reading on.
// Unlike the vertex shader, the fragment shader actually does compute
// the shading of geometry. For every pixel in your program's output
// screen, the fragment shader is run for every bit of geometry that
// particular pixel overlaps. By implicitly interpolating the position
// data passed into the fragment shader by the vertex shader, the fragment shader
// can compute what color to apply to its pixel based on things like vertex
// position, light position, and vertex color.
precision highp float;

// referenced https://en.wikibooks.org/wiki/GLSL_Programming/Unity/Brushed_Metal#Implementation_of_Ward's_BRDF_Model

uniform vec4 u_Color; // The color with which to render this instance of geometry.
uniform float u_Time;
uniform vec4 u_Eye;

// These are the interpolated values out of the rasterizer, so you can't know
// their specific values without knowing the vertices that contributed to them
in vec4 fs_Nor;
in vec4 fs_LightVec;
in vec4 fs_Col;
in vec4 fs_Pos;

in vec4 fs_Tangent;

in vec2 fs_UV;
in float displacement;

out vec4 out_Col; // This is the final output color that you will see on your
                  // screen for the pixel that is currently being processed.

vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d)
{
     return a + b*cos(6.28318f * (c*t+d));
}    


void main()
{
        vec3 b = vec3(0.6, 0.6, 0.7);
        vec3 c = vec3(0.2, 0.2, 0.2);
        vec3 d = vec3(8.f, 8.f, 9.f);
        vec3 a = vec3(0.f, 0.0f, 0.f);

       vec4 diffuseColor = vec4(palette(displacement, a, b, c, d),1.f); // + fs_Nor


      /*      vec4 normalDirection = normalize(fs_Nor);
        vec4 tangentDirection = normalize(fs_Tangent);
        vec4 viewDirection = normalize(fs_Pos - u_Eye);
       
       vec4 vertexToLightSource = -1.f*fs_LightVec;
       float distance = length(vertexToLightSource);
       float attenuation = 1.0f / (2.f * distance);
       vec4 lightDirection = fs_LightVec;

       vec4 halfwayVector = normalize(lightDirection + viewDirection);
       vec4 binormalDirection = vec4(cross(vec3(normalDirection), vec3(tangentDirection)),0);
       float dotLN = dot(lightDirection, normalDirection);

       //vec4 diffuseColor = u_Color;

        vec4 diffuseReflection = attenuation * vec4(1, 1, 1, 1) * diffuseColor * max(0.0, dotLN);
        float alphaX = 1.f;
        float alphaY = 4.0f;

        vec4 specularReflection;
        if(dotLN < 0.f)
        {
            specularReflection = vec4(0.f, 0.f, 0.f, 1.f);
        } else {
            float dotHN = dot(halfwayVector, normalDirection);
            float dotVN = dot(viewDirection, normalDirection);
            float dotHTAlphaX = dot(halfwayVector, tangentDirection) / alphaX;
            float dotHTAlphaY = dot(halfwayVector, binormalDirection) / alphaY;
            specularReflection = .01 * attenuation * vec4(1.f, 0.f, 1.f, 1.f) * sqrt(max(0.0, dotLN / dotVN)) * exp(-2.0f * (dotHTAlphaX * dotHTAlphaX) + dotHTAlphaY * dotHTAlphaY) / (1.0f + dotHN);
        }
        

        // Calculate the diffuse term for Lambert shading
        float diffuseTerm = dot(normalize(fs_Nor), normalize(fs_LightVec));
        // Avoid negative lighting values
         diffuseTerm = clamp(diffuseTerm, 0.f, 1.f);

        float ambientTerm = attenuation;

        float lightIntensity = diffuseTerm + ambientTerm;   //Add a small float value to the color multiplier
                                                            //to simulate ambient lighting. This ensures that faces that are not
                                                            //lit by our point light are not completely black.*/

                                                            //vec4 diffuseColor = u_Color;

        // Calculate the diffuse term for Lambert shading
        float diffuseTerm = dot(normalize(fs_Nor), normalize(fs_LightVec));
        // Avoid negative lighting values
        // diffuseTerm = clamp(diffuseTerm, 0, 1);

        float ambientTerm = 0.2;

        float lightIntensity = diffuseTerm + ambientTerm;   //Add a small float value to the color multiplier
                                                            //to simulate ambient lighting. This ensures that faces that are not
                                                            //lit by our point light are not completely black.

        // Compute final shaded color
        out_Col = abs(vec4(diffuseColor.rgb * lightIntensity, diffuseColor.a));

        // Compute final shaded color
       // out_Col = vec4(diffuseColor.rgb * lightIntensity + diffuseReflection.rgb + specularReflection.rgb, diffuseColor.a);

      // out_Col = diffuseColor;
}
